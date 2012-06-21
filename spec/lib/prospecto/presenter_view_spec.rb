require "spec_helper"

describe Prospecto::PresenterView do
  let(:person) { Person.new }

  describe "#proxies" do
    [ProxiedPresenter, NestedProxiedPresenter].each do |klass|
      describe "with #{klass}" do
        subject { klass.new(person: person) }

        its(:person_full_name) { should == person.full_name }
        its(:person_age) { should == person.age}
        its(:protected_methods) { should include(:person) }
      end
    end
  end

  describe "#accepts" do
    subject { AcceptancePresenter.new(person: person) }

    its(:name) { should == person.full_name }
    its(:protected_methods) { should include(:person) }
  end

  describe "#presents" do
    subject { PresentsPresenter.new(person: person) }

    its(:person) { should == person }
    its(:name) { should == person.full_name }
    its(:protected_methods) { should_not include(:person) }
  end

  describe "#decorates" do
    [DecoratesPresenter, NestedDecoratesPresenter].each do |klass|
      describe "with #{klass}" do
        subject { klass.new(person: person) }

        its(:full_name) { should == person.full_name }
        its(:age) { should == 25 }
        it { should_not respond_to(:person) }

        it "accepts parameters correctly" do
          subject.plus_one(1).should == 2
        end
      end
    end
  end
end
