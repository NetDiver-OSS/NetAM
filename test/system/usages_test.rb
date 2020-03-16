require "application_system_test_case"

class UsagesTest < ApplicationSystemTestCase
  setup do
    @usage = usages(:one)
  end

  test "visiting the index" do
    visit usages_url
    assert_selector "h1", text: "Usages"
  end

  test "creating a Usage" do
    visit usages_url
    click_on "New Usage"

    fill_in "Ip used", with: @usage.ip_used
    click_on "Create Usage"

    assert_text "Usage was successfully created"
    click_on "Back"
  end

  test "updating a Usage" do
    visit usages_url
    click_on "Edit", match: :first

    fill_in "Ip used", with: @usage.ip_used
    click_on "Update Usage"

    assert_text "Usage was successfully updated"
    click_on "Back"
  end

  test "destroying a Usage" do
    visit usages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Usage was successfully destroyed"
  end
end
