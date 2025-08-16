module AttributeUtils
  module_function

  NOW = Time.current
  def create_hash
    {
      created_at: NOW
    }
  end

  def update_hash
    {
      updated_at: NOW
    }
  end
end