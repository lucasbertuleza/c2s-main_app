require "rails_helper"

RSpec.describe "tasks/show" do
  before do
    assign(:task, Task.create!(
      user: nil,
      url: "Url",
      uuid: "Uuid",
      status: 2,
      data: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Uuid/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
