class UploadSerializer < ActiveModel::Serializer
  attributes :id, :name, :file_file_name, :file_content_type, :file_file_size, :file_thumbnail_url, :file_url

  def file_thumbnail_url
    object.file.url(:square_200)
  end

  def file_url
    object.file.url
  end
end