require "rails_helper"

RSpec.describe "tasks/new" do
  before do
    assign(:task, Task.new(
      user: nil,
      url: "MyString",
      uuid: "MyString",
      status: 1,
      data: ""
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input[name=?]", "task[user_id]"

      assert_select "input[name=?]", "task[url]"

      assert_select "input[name=?]", "task[uuid]"

      assert_select "input[name=?]", "task[status]"

      assert_select "input[name=?]", "task[data]"
    end
  end
end
