window.onbeforeunload = e => "";
function compile() {
	var o = "";
	try {
		o = module.exports.parse(editor.getValue()).map(e => e[0])
	} catch (e) {
		alert(e.message)
		return
	}
	outp.setValue(JSON.stringify(o, null, 2))
}

function run() {
	var o = "";
	try {
		o = module.exports.parse(editor.getValue()).map(e => e[0])
	} catch (e) {
		alert(e.message)
		return
	}
	Calc.setExpressions(o)
}