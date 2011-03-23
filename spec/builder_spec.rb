require 'rspec'
require File.expand_path(File.dirname(__FILE__) + '/../lib/hair_trigger/builder.rb')

HairTrigger::Builder.show_warnings = false

class MockAdapter
  attr_reader :adapter_name
  def initialize(type)
    @adapter_name = type
  end
end

def builder
  HairTrigger::Builder.new(nil, :adapter => @adapter)
end

describe "builder" do
  context "chaining" do
    it "should use the last redundant chained call" do
      @adapter = MockAdapter.new("mysql")
      builder.where(:foo).where(:bar).options[:where].should be(:bar)
    end
  end

  context "mysql" do
    before(:each) do
      @adapter = MockAdapter.new("mysql")
    end

    it "should create a single trigger for a group" do
      trigger = builder.on(:foos).after(:update){ |t|
        t.where('BAR'){ 'BAR' }
        t.where('BAZ'){ 'BAZ' }
      }
      trigger.generate.grep(/CREATE.*TRIGGER/).size.should eql(1)
    end

    it "should disallow nested groups" do
      lambda {
        builder.on(:foos){ |t|
          t.after(:update){ |t|
            t.where('BAR'){ 'BAR' }
            t.where('BAZ'){ 'BAZ' }
          }
        }
      }.should raise_error
    end

    it "should accept security" do
      builder.on(:foos).after(:update).security(:definer){ "FOO" }.generate.
        grep(/DEFINER/).size.should eql(0) # default, so we don't include it
      builder.on(:foos).after(:update).security("CURRENT_USER"){ "FOO" }.generate.
        grep(/DEFINER = CURRENT_USER/).size.should eql(1)
      builder.on(:foos).after(:update).security("'user'@'host'"){ "FOO" }.generate.
        grep(/DEFINER = 'user'@'host'/).size.should eql(1)
    end

    it "should reject :invoker security" do
      lambda { builder.on(:foos).after(:update).security(:invoker){ "FOO" } }.
        should raise_error
    end

    it "should reject multiple timings" do
      lambda { builder.on(:foos).after(:update, :delete){ "FOO" } }.
        should raise_error
    end
  end

  context "postgresql" do
    before(:each) do
      @adapter = MockAdapter.new("postgresql")
    end

    it "should create multiple triggers for a group" do
      trigger = builder.on(:foos).after(:update){ |t|
        t.where('BAR'){ 'BAR' }
        t.where('BAZ'){ 'BAZ' }
      }
      trigger.generate.grep(/CREATE.*TRIGGER/).size.should eql(2)
    end

    it "should allow nested groups" do
      trigger = builder.on(:foos){ |t|
        t.after(:update){ |t|
          t.where('BAR'){ 'BAR' }
          t.where('BAZ'){ 'BAZ' }
        }
        t.after(:insert){ 'BAZ' }
      }
      trigger.generate.grep(/CREATE.*TRIGGER/).size.should eql(3)
    end

    it "should accept security" do
      builder.on(:foos).after(:update).security(:invoker){ "FOO" }.generate.
        grep(/SECURITY/).size.should eql(0) # default, so we don't include it
      builder.on(:foos).after(:update).security(:definer){ "FOO" }.generate.
        grep(/SECURITY DEFINER/).size.should eql(1)
    end

    it "should reject arbitrary user security" do
      lambda { builder.on(:foos).after(:update).security("'user'@'host'"){ "FOO" } }.
        should raise_error
    end

    it "should accept multiple timings" do
      builder.on(:foos).after(:update, :delete){ "FOO" }.generate.
        grep(/UPDATE OR DELETE/).size.should eql(1)
    end

    it "should reject long names" do
      lambda { builder.name('A'*65).on(:foos).after(:update){ "FOO" }}.
        should raise_error
    end
  end

  context "sqlite" do
    before(:each) do
      @adapter = MockAdapter.new("sqlite")
    end

    it "should create multiple triggers for a group" do
      trigger = builder.on(:foos).after(:update){ |t|
        t.where('BAR'){ 'BAR' }
        t.where('BAZ'){ 'BAZ' }
      }
      trigger.generate.grep(/CREATE.*TRIGGER/).size.should eql(2)
    end

    it "should allow nested groups" do
      trigger = builder.on(:foos){ |t|
        t.after(:update){ |t|
          t.where('BAR'){ 'BAR' }
          t.where('BAZ'){ 'BAZ' }
        }
        t.after(:insert){ 'BAZ' }
      }
      trigger.generate.grep(/CREATE.*TRIGGER/).size.should eql(3)
    end

    it "should reject security" do
      lambda { builder.on(:foos).after(:update).security(:definer){ "FOO" } }.
        should raise_error
    end

    it "should reject for_each :statement" do
      lambda { builder.on(:foos).after(:update).for_each(:statement){ "FOO" } }.
        should raise_error
    end

    it "should reject multiple timings" do
      lambda { builder.on(:foos).after(:update, :delete){ "FOO" } }.
        should raise_error
    end
  end
end