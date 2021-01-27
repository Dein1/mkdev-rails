require 'rails_helper'

RSpec.describe Event, type: :model do
  
  before(:each) do
    DatabaseCleaner.clean
    @event = Event.create(title: "Cool event", description: "Not very long description", starttime: Time.now, endtime: Time.now + 1.day)
  end

  it 'can create' do
    expect(@event).to be_valid
  end

  it 'can read' do
    expect(Event.find_by_title("Cool event")).to eq(@event)
  end

  it 'can update' do
    @event.update(title: "Even cooler event")
    expect(Event.find_by_title("Even cooler event")).to eq(@event)
  end

  it 'can be destroyed' do
    @event.destroy
    expect(Event.count).to eq(0)
  end

  it 'is not valid without a title' do
    @event.update(title: "")
    expect(@event).to_not be_valid
  end
end
