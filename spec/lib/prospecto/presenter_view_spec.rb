require "spec_helper"

describe Prospecto::PresenterView do
  let(:person) { OpenStruct.new(full_name: "Bob Smith", age: 43) }

  describe "#proxies" do
    subject { ProxiedPresenter.new(person: person) }

    its(:person_full_name) { should == person.full_name }
    its(:person_age) { should == person.age}
    its(:protected_methods) { should include(:person) }
  end

  describe "#accepts" do
    subject { AcceptancePresenter.new(person: person) }

    its(:name) { should == person.name }
    its(:protected_methods) { should include(:person) }
  end

  describe "#presents" do
    subject { PresentsPresenter.new(person: person) }

    its(:person) { should == person }
    its(:name) { should == person.name }
    its(:protected_methods) { should_not include(:person) }
  end

  describe "#decorates" do
    subject { DecoratesPresenter.new(person: person) }

    its(:full_name) { should == person.full_name }
    its(:age) { should == 25 }
    it { should_not respond_to(:person) }
  end
end
