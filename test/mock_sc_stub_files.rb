EXAMPLE_SC_STUB_1_CONTENT = <<'EOF'
MyModuleExampleClass : MyModuleExampleSuperclass {
	classvar
		classAttribute,
		<readableClassAttribute,
		>writeableClassAttribute,
		<>accessableClassAttribute,
		classAttributeWithInitialValue="A string"
	;

	var
		attribute,
		<readableAttribute,
		>writeableAttribute,
		<>accessableAttribute,
		attributeWithInitialValue=4
	;

	*new { |initArgument1, initArgument2=\aSymbol, initArgument3="A default string value"|
	}

	// A comment

/*
	Note:
	This is a comment spanning multiple lines.
*/

	instanceMethodWithoutArgument {
	}

	instanceMethodWithOneArgument { |argument|
	}

	instanceMethodWithTwoArguments { |argument1, argument2|
	}

	instanceMethodWithArgumentsThatHaveDefaultValues { |booleanTrueArgument=true, booleanFalseArgument=false, floatArgument=3.14, stringArgument="A default string value", symbolArgument=\aDefaultSymbolValue, nilArgument|
	}

	predicateInstanceMethodWithTwoArguments { |argument1, argument2|
	}

	setter_ { |newValue|
	}

	asString {
	}

	instanceMethodWithOneArgumentAndMethodBodies { |argument|
		"Hello % from SuperCollider!".format(argument).postln;
		"Hello again from SuperCollider!".postln;
	}

	instanceMethodWithScArgumentsPrefixedWithArg { |argArgument1, argArgument2|
	}

	scMethod {
	}

	*classMethodWithoutArgument {
	}

	*classMethodWithOneArgument { |argument|
	}

	*classMethodWithTwoArguments { |argument1, argument2|
	}

	*predicateClassMethodWithTwoArguments { |argument1, argument2|
	}

	*classSetter_ { |newValue|
	}
}
EOF

EXAMPLE_SC_STUB_2_CONTENT = <<'EOF'
MyModuleExampleClass2 {
	classvar
		classAttribute="test",
		<readableClassAttribute=\test
	;

	var
		attribute,
		<readableAttribute=false
	;

	*new { |initArgument1, initArgument2=\aSymbol, initArgument3="A string"|
		^super.new.initMyModuleExampleClass2(initArgument1, initArgument2, initArgument3);
	}

	initMyModuleExampleClass2 { |argInitArgument1, argInitArgument2, argInitArgument3|
	}

}
EOF

EXAMPLE_SC_STUB_3_CONTENT = <<'EOF'
MyModuleExampleClass3 {
}
EOF

EXAMPLE_SC_STUB_4_CONTENT = <<'EOF'
MyModuleExampleClass4 {
	*new {
		^super.new.initMyModuleExampleClass4;
	}

	initMyModuleExampleClass4 {
	}

	onlyInSuperCollider {
	}
}
EOF

EXAMPLE_SC_STUB_5_CONTENT = <<'EOF'
MyModuleExampleClass5 {
	var
		anAttribute,
		<scAttribute
	;

	*new {
	}

	initMyModuleExampleClass5 { |test1, test2|
	}

	anAttribute_ { |argAnAttribute|
	}
}
EOF

EXAMPLE_SC_STUB_1 = {
	:destination => {
		:filename => "MyModuleExampleClass.sc",
		:filetype => "sc",
	},
	:content => EXAMPLE_SC_STUB_1_CONTENT
}

EXAMPLE_SC_STUB_2 = {
	:destination => {
		:filename => "MyModuleExampleClass2.sc",
		:filetype => "sc",
	},
	:content => EXAMPLE_SC_STUB_2_CONTENT
}

EXAMPLE_SC_STUB_3 = {
	:destination => {
		:filename => "MyModuleExampleClass3.sc",
		:filetype => "sc",
	},
	:content => EXAMPLE_SC_STUB_3_CONTENT
}

EXAMPLE_SC_STUB_4 = {
	:destination => {
		:filename => "MyModuleExampleClass4.sc",
		:filetype => "sc",
	},
	:content => EXAMPLE_SC_STUB_4_CONTENT
}

EXAMPLE_SC_STUB_5 = {
	:destination => {
		:filename => "MyModuleExampleClass5.sc",
		:filetype => "sc",
	},
	:content => EXAMPLE_SC_STUB_5_CONTENT
}
