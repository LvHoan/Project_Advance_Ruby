module AttributeUtils
  module_function

  def timestamp_attribute
    now = Time.current
    {
      created_at: now,
      updated_at: now
    }
  end
end