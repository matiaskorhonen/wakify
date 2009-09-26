# Helpers for the sitemap views
module SitemapHelper
  # Generate a w3c format date
  def w3c_date(date)
    date.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end
end
