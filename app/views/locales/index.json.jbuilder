json.array!(@locales) do |locale|
  json.extract! locale, :id, :title, :description, :state, :street, :number, :zip, :category_id
  json.url locale_url(locale, format: :json)
end
