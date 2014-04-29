# TypeTempest

Type Tempest is **an experimental** type-checking gem for Ruby methods, which automates the tedious pattern of `raise ArgumentError, "Blah is ivalid" unless blah.is_a?(String)`

Say what you will about dynamic typing -- this is for those times where one does not want a million possibilities in their inputs.

**Note about experimental nature:** This gem eval()s code blocks that it is given. This is dangerous! Don't use this on anything in production!

## Installation

Add this line to your application's Gemfile:

    gem 'type_tempest'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install type_tempest

## Usage

Type Tempest adds two similar, top-level, and syntactically-odd methods to Ruby: `check()` and `strict()`.

`check()` passes if the given variable matches the given class, or one of its subclasses. (`var.is_a?(Klass)`).

`strict()` passes if the given variable matches the given class. (`var.instance_of?(Klass)`)

**Use these shortcuts as the first line in a method whose parameters you would like to check, as such:**


	def checkme(a_string, a_int, another_string)
		check (String) {:a_string}
		check (Fixnum) {:a_int}
		strict (String) {:another_string}

		# some code here...

		"Done!"
	end

Behind the scenes, TypeTempest eval()s the result of the given block and throws `TypeMismatchError` if the result's type differs from what is expected (as in, it fails `is_a?()` or `instance_of?()`). In this example, the first call to `checkme()` would pass, but the second would throw `TypeMismatchError`:


    checkme("Hi", 2, "ada") # => "Done!"
    checkme(0,0,0) # => Parameter a_string should be of type String, but was instead Fixnum (TypeMismatchError)

## Comments

The `check (String) {:a_string}` syntax is awkward and not very Ruby-like. Using blocks to access the caller's binding is a bit of a hack, and if there were an easier way to walk the call-stack and derive method parameters then the syntax would be different.

An ideal version of this feature would look like this: `check String a_string` or `strict Geometry::Box box_obj`. Unfortunately...

* I am not aware of any way to cheaply retreive both the contents (variable names, etc) and values of a block.
* I am not aware of any way to cheaply walk the call-stack in a way that allows one to retreive a caller's parameter names and values.
* I am not aware of any other way to evaluate code in the context of the caller.
* Block syntax seems to only work when method parameters are wrapped in `(` and `)`.
* Passing `local_variables`, `_`, or a self-reference to `check()` would further clutter syntax.
* Blocks must be designated with `{}` or `do..end`

For these reasons, syntax is presented as-is, with possible tweaks towards the stated goal saved for major revisions.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
