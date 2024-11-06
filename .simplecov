# extends rails profile
SimpleCov.start "rails" do
  add_filter "vendor"

  add_group "Components",  "app/components"
  add_group "Decorators",  "app/decorators"
  add_group "Jobs",        "app/jobs"
  add_group "Services",    "app/services"

  minimum_coverage_by_file line: 90
end