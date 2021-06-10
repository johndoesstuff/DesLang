window.onbeforeunload = e => "";
function compile() {
	var o = "";
	try {
		o = module.exports.parse(editor.getValue())
	} catch (e) {
		alert(e.message)
		return
	}
	outp.setValue(JSON.stringify(o, null, 2))
}

function run() {
	compile();
	var state = Calc.getState();
	var o = "";
	try {
		o = module.exports.parse(editor.getValue())
	} catch (e) {
		alert(e.message)
		return
	}
	state.expressions.list = o;
	Calc.setState(state);
}