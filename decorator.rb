class QantasCustomerDecorator < Customer
  attr_accessor :qff_number
  def self.new_from_attributes(record)
    new.tap do |q_cust|
      record.each do |name, value|
        q_cust.send("#{name}=", value)
      end
      q_cust.readonly!
    end
  end
  def self.serialize_into_session(record)
    store.write(record)
  end
  def self.serialize_from_session(session_keyname, session_value)
    store.read(session_value)
  end
  def valid?
    # At a minimum, without a qff number, we're not valid
    qff_number.present?
  end
  def ==(other)
    self.qff_number == other.qff_number
  end
  alias :eql? :==
  
  private
  def self.store
    Authentications::QantasCustomerStore.new
  end
end
