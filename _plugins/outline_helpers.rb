require 'date'
require 'pathname'
module OutlineHelpers
  def all_outlines(resources=sitemap.resources)
    resources.select { |resource| resource.data[:layout] == 'today' }
  end

  # an outline's path takes the form "outlines/yyyy-mm-dd.html"
  def outline_date(outline_path)
    Date.parse(
      Pathname.new(outline_path)
              .basename
              .sub_ext('')
              .to_s
    )
  end

  def get_known_dates
    all_outlines.map { |o| yyyy_mm_dd_for outline_date(o.path)}.inspect
  end
end
