require "type_tempest/version"

class TypeMismatchError < TypeError

end


def check(type, &block)

  type = type.to_s.constantize if defined?(ActiveSupport) && (type.instance_of?(Symbol) || type.instance_of?(String))
  raise TypeError, "`type` must be an object of type Class" unless type.instance_of?(Class)

  var    = yield
  vartyp = eval("#{var.to_s}", block.binding)

  raise TypeMismatchError, "Parameter #{var} should be of type #{type}, but was instead #{vartyp.class}" unless vartyp.is_a?(type)

end


def strict(type, &block)

  type = type.to_s.constantize if defined?(ActiveSupport) && (type.instance_of?(Symbol) || type.instance_of?(String))
  raise TypeError, "`type` must be an object of type Class" unless type.instance_of?(Class)

  var    = yield
  vartyp = eval("#{var.to_s}", block.binding)

  raise TypeMismatchError, "Parameter #{var} should be of type #{type}, but was instead #{vartyp.class}" unless vartyp.instance_of?(type)

end
