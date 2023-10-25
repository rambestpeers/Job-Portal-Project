require "application_system_test_case"

class JobsTest < ApplicationSystemTestCase
  setup do
    @job = jobs(:one)
  end

  test "visiting the index" do
    visit jobs_url
    assert_selector "h1", text: "Jobs"
  end

  test "should create job" do
    visit jobs_url
    click_on "New job"

    fill_in "Description", with: @job.description
    fill_in "Job author", with: @job.job_author
    fill_in "Job category", with: @job.job_category
    fill_in "Job company", with: @job.job_company
    fill_in "Location", with: @job.location
    fill_in "Salary", with: @job.salary
    fill_in "Title", with: @job.title
    click_on "Create Job"

    assert_text "Job was successfully created"
    click_on "Back"
  end

  test "should update Job" do
    visit job_url(@job)
    click_on "Edit this job", match: :first

    fill_in "Description", with: @job.description
    fill_in "Job author", with: @job.job_author
    fill_in "Job category", with: @job.job_category
    fill_in "Job company", with: @job.job_company
    fill_in "Location", with: @job.location
    fill_in "Salary", with: @job.salary
    fill_in "Title", with: @job.title
    click_on "Update Job"

    assert_text "Job was successfully updated"
    click_on "Back"
  end

  test "should destroy Job" do
    visit job_url(@job)
    click_on "Destroy this job", match: :first

    assert_text "Job was successfully destroyed"
  end
end
