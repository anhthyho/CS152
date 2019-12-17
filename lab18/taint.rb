=begin
Update the Record class so that updates with either
a tainted name or a tainted value are ignored.
Do this first by explicitly checking the taint on a field.

Would this be sufficient if an attacker could control part of the code?
If not, how could the different taint modes be useful?
=end

class Record
  def initialize fields
    @fields = fields
  end

  #ignore tained values on update 
  def set_property name, value
    if name.tainted?
        puts "error on field name: " + name + " " + value
    elsif value.tainted?
        puts "error on value: " + name + " " + value
    else 
        @fields[name] = value
    end
  end

  def get_property name
    @fields[name]
  end
end

r = Record.new 'fname' => 'Rick', 'lname' => 'Grimes', 'profession' => 'Police Officer'
r.set_property 'profession'.taint, 'Zombie Hunter'
r.set_property 'lname', 'Smith'.taint

p r.get_property 'profession'
p r.get_property 'lname'

