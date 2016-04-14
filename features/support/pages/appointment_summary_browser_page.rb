class AppointmentSummaryBrowserPage < SitePrism::Page
  set_url '/admin/appointment_summaries'

  elements :appointments, '.t-appointment'
  elements :pages, 'li.page'

  element :start_date, '.t-start'
  element :end_date, '.t-end'
end
