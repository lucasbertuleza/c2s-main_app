require "rails_helper"

RSpec.describe "tasks/edit" do
  let(:task) {
    Task.create!(
      user: nil,
      url: "MyString",
      uuid: "MyString",
      status: 1,
      data: ""
    )
  }

  before do
    assign(:task, task)
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(task), "post" do
      assert_select "input[name=?]", "task[user_id]"

      assert_select "input[name=?]", "task[url]"

      assert_select "input[name=?]", "task[uuid]"

      assert_select "input[name=?]", "task[status]"

      assert_select "input[name=?]", "task[data]"
    end
  end
end
