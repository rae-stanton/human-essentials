require_relative "organization_page"

class OrganizationReportsProductDrivesPage < OrganizationPage
  def org_page_path
    "reports/product_drives"
  end

  def product_drive_total_donations
    within product_drives_section do
      parse_formatted_integer find(".total_received_donations").text
    end
  end

  def product_drive_total_money_raised
    within product_drives_section do
      parse_formatted_currency find(".total_money_raised").text
    end
  end

  def has_product_drives_section?
    has_selector? product_drives_selector
  end

  def recent_product_drive_donation_links
    within product_drives_section do
      all(".donation a").map(&:text)
    end
  end

  def product_drives_section
    find product_drives_selector
  end

  def product_drives_selector
    "#product_drives"
  end

  def filter_to_date_range(range_name, custom_dates = nil)
    select_date_filter_range range_name

    if custom_dates.present?
      fill_in :filters_date_range, with: ""
      fill_in :filters_date_range, with: custom_dates
      page.find(:xpath, "//*[contains(text(),'- Dashboard')]").click
    end

    click_on "Filter"
  end
end
