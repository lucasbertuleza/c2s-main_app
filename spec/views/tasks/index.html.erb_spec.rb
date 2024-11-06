require "rails_helper"

RSpec.describe "tasks/index" do
  before do
    assign(:tasks, [
      Task.create!(
        user: nil,
        url: "Url",
        uuid: "Uuid",
        status: 2,
        data: ""
      ),
      Task.create!(
        user: nil,
        url: "Url",
        uuid: "Uuid",
        status: 2,
        data: ""
      )
    ])
  end

  it "renders a list of tasks" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Uuid".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("".to_s), count: 2
  end
end
