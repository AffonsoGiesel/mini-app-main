require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'Is created with default share status nil' do
    expect(Task.new.share).to eq nil
  end

  it 'Is created with default \'status\' value os 0' do
    expect(Task.new.status.to_i).to eq 0
  end

  it 'Is created with default priority of 0' do
    expect(Task.new.priority.to_i).to eq 0
  end

  subject{ build(:task)}
  it {is_expected.to respond_to :title}
  it {is_expected.to respond_to :description}
  it {is_expected.to respond_to :status}
  it {is_expected.to respond_to :priority}
  it {is_expected.to respond_to :share}

  it{ should validate_presence_of(:description)}

  it{ should validate_length_of(:title).is_at_least(4).is_at_most(20)}
  it{ should validate_length_of(:description).is_at_most(280)}

  it{ should belong_to(:user).class_name(User)}
  it{ should have_many(:comments).class_name(Comment)}

  it { should define_enum_for(:status).with_values(incomplete: 0, complete: 10) }
  it { should define_enum_for(:priority).with_values(low: 0, medium: 10, high: 20) }


  end

