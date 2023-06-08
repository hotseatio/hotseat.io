# typed: false
# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://hotseat.io"
SitemapGenerator::Sitemap.public_path = "/app/storage"
SitemapGenerator::Sitemap.create_index = true

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.

  Instructor.find_each do |instructor|
    add instructor_path(instructor), lastmod: instructor.updated_at
  end

  Course.find_each do |course|
    course.instructors.find_each do |instructor|
      add course_instructor_path(course, instructor), lastmod: course.updated_at
    end
  end

  SubjectArea.find_each do |subject_area|
    add subject_area_path(subject_area), lastmod: subject_area.updated_at
  end
end
