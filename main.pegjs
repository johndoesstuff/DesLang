{
	var DesLang = {}
	DesLang.makeVar = (e => {
		if (!e) return "";
		return e[0] + (e[1] ? ("_{" + e.substr(1) + "}") : "");
	});
	DesLang.mapFunc = (e => {
		if (DesLang.specialFuncs.includes(e)) return e
		return DesLang.funcMap[e]
	})
	DesLang.funcMap = {
		"floor": "\\operatorname{floor}",
		"ceil": "\\operatorname{ceil}",
		"abs": "\\operatorname{abs}",
		"round": "\\operatorname{round}",
		"sin": "\\sin ",
		"cos": "\\cos ",
		"tan": "\\tan ",
		"csc": "\\csc ",
		"sec": "\\sec ",
		"cot": "\\cot ",
		"arcsin": "\\sin^{-1}",
		"arccos": "\\cos^{-1}",
		"arctan": "\\tan^{-1}",
		"arccsc": "\\csc^{-1}",
		"arcsec": "\\sec^{-1}",
		"arccot": "\\cot^{-1}",
		"sinh": "\\sinh ",
		"cosh": "\\cosh ",
		"tanh": "\\tanh ",
		"csch": "\\csch ",
		"sech": "\\sech ",
		"coth": "\\coth ",
		"arcsinh": "\\sinh^{-1}",
		"arccosh": "\\cosh^{-1}",
		"arctanh": "\\tanh^{-1}",
		"arccsch": "\\csch^{-1}",
		"arcsech": "\\sech^{-1}",
		"arccoth": "\\coth^{-1}",
		"total": "\\operatorname{total}",
		"len": "\\operatorname{length}",
		"length": "\\operatorname{length}",
		"mean": "\\operatorname{mean}",
		"median": "\\operatorname{median}",
		"min": "\\min ",
		"max": "\\max ",
		"quartile": "\\operatorname{quartile}",
		"quantile": "\\operatorname{quantile}",
		"stdev": "\\operatorname{stdev}",
		"stdevp": "\\operatorname{stdevp}",
		"mad": "\\operatorname{mad}",
		"var": "\\operatorname{var}",
		"cov": "\\operatorname{cov}",
		"corr": "\\operatorname{corr}",
		"spearman": "\\operatorname{spearman}",
		"nCr": "\\operatorname{nCr}",
		"nPr": "\\operatorname{nPr}",
		"stats": "\\operatorname{stats}",
		"ttest": "\\operatorname{ttest}",
		"tscore": "\\operatorname{tscore}",
		"ittest": "\\operatorname{ittest}",
		"histogram": "\\operatorname{histogram}",
		"dotplot": "\\operatorname{dotplot}",
		"boxplot": "\\operatorname{boxplot}",
		"normaldist": "\\operatorname{normaldist}",
		"tdist": "\\operatorname{tdist}",
		"poissondist": "\\operatorname{poissondist}",
		"binomialdist": "\\operatorname{binomialdist}",
		"uniformdist": "\\operatorname{uniformdist}",
		"pdf": "\\operatorname{pdf}",
		"cdf": "\\operatorname{cdf}",
		"inversecdf": "\\operatorname{inversecdf}",
		"random": "\\operatorname{random}",
		"rand": "\\operatorname{random}",
		"join": "\\operatorname{join}",
		"sort": "\\operatorname{sort}",
		"shuffle": "\\operatorname{shuffle}",
		"lcm": "\\operatorname{lcm}",
		"gcd": "\\gcd ",
		"mod": "\\operatorname{mod}",
		"sign": "\\operatorname{sign}",
		"sgn": "\\operatorname{sign}",
		"exp": "\\exp ",
		"ln": "\\ln ",
		"polygon": "\\operatorname{polygon}",
	};
	DesLang.binarySymbMap = {
		"+":"+",
		"-":"-",
		"*":"\\cdot ",
		"=":"=",
	};
	DesLang.unarySymb = [
		"~",
		"!",
	];
	DesLang.varMap = {
		"pi":"\\pi ",
		"alpha":"\\alpha ",
		"beta":"\\beta ",
		"gamma":"\\gamma ",
		"Gamma":"\\Gamma ",
		"delta":"\\delta ",
		"Delta":"\\Delta ",
		"epsilon":"\\epsilon ",
		"zeta":"\\zeta ",
		"eta":"\\eta ",
		"Theta":"\\Theta ",
		"iota":"\\iota ",
		"kappa":"\\kappa ",
		"lambda":"\\lambda ",
		"Lambda":"\\Lambda ",
		"mu":"\\mu ",
		"nu":"\\nu ",
		"Pi":"\\Pi ",
		"rho":"\\rho ",
		"sigma":"\\sigma ",
		"Sigma":"\\Sigma ",
		"tau":"\\tau ",
		"upsilon":"\\upsilon ",
		"Upsilon":"\\Upsilon ",
		"phi":"\\phi ",
		"Phi":"\\Phi ",
		"chi":"\\chi ",
		"psi":"\\psi ",
		"Psi":"\\Psi ",
		"omega":"\\omega ",
		"Omega":"\\Omega ",
		"inf":"\\infty ",
		"infty":"\\infty ",
		"theta":"\\theta ",
		"phi":"\\phi ",
	}
	DesLang.specialFuncs = [
		"log",
		"sqrt",
		"sum",
		"prod",
		"nthroot",
		"int",
		"percof",
		"factorial",
		"derivative",
	];
	DesLang.defaultFuncs = Object.keys(DesLang.funcMap).concat(DesLang.specialFuncs);
	DesLang.isDefaultFunc = e => DesLang.defaultFuncs.includes(e);
	DesLang.testKeyword = e => {
		if (DesLang.isDefaultFunc(e)) return DesLang.mapFunc(e);
		else if (Object.keys(DesLang.varMap).includes(e)) return DesLang.varMap[e];
		else return DesLang.makeVar(e)
	}
	var pl = "\\left(";
	var pr = "\\right)";
	var ll = "\\left[";
	var lr = "\\right]";
	var bl = "\\left\\{";
	var br = "\\right\\}";
	DesLang.idIter = 0;
	DesLang.genId = () => { return DesLang.idIter++ };
	DesLang.createFunction = e => {
		var args = e.slice(2, e.length-1);
		if (DesLang.specialFuncs.includes(e[0])) {
			if (e[0] == "log") {
				if (args.length <= 1) e[0] = "\\log"
				else return "\\log_{" + args[1] + "}" + pl + args[0] + pr;
			} else if (e[0] == "sqrt") {
				return "\\sqrt{" + args[0] + "}";
			} else if (e[0] == "sum") {
				if (args.length == 3) return "\\sum_{" + args[0] + "}^{" + args[1] + "}" + pl + args[2] + pr
			} else if (e[0] == "prod") {
				if (args.length == 3) return "\\prod_{" + args[0] + "}^{" + args[1] + "}" + pl + args[2] + pr
			} else if (e[0] == "nthroot") {
				if (args.length == 2) return "\\sqrt[" + args[1] + "]{" + args[0] + "}";
			} else if (e[0] == "int") {
				if (args.length == 4) return pl + "\\int_{" + args[0] + "}^{" + args[1] + "}" + pl + args[2] + pr + "d" + args[3] + pr;
			} else if (e[0] == "percof") {
				if (args.length == 2) return pl + pl + args[0] + pr + "\\%\\operatorname{of}" + pl + args[1] + pr + pr;
			} else if (e[0] == "factorial") {
				return pl + pl + args[0] + pr + "!" + pr
			} else if (e[0] == "derivative") {
				if (args.length == 2) return "\\frac{" + "}{" + "}"
			}
		} else {
			e[0] = DesLang.testKeyword(e[0])
		}
		return e[0] + pl + args.join() + pr;
	}
	DesLang.packageFunction = e => {
		if (!DesLang.packagedFunctionNames.includes(e)) DesLang.packagedFunctions.push(DesLang.packages[e])
	}
	DesLang.packagedFunctions = [];
	DesLang.packagedFunctionNames = [];
	DesLang.packages = {
		"|" : "\\ne\\left(\\pm,\\mp\\right)=\\sum_{\\nparallel=0}^{\\log_{2}\\left(\\max\\left(\\left|\\pm\\right|,\\left|\\mp\\right|,1\\right)\\right)}\\left\\{\\operatorname{mod}\\left(\\pm,2^{\\left(\\nparallel+1\\right)}\\right)\\ge2^{\\nparallel}:2^{\\nparallel},\\operatorname{mod}\\left(\\mp,2^{\\left(\\nparallel+1\\right)}\\right)\\ge2^{\\nparallel}:2^{\\nparallel},0\\right\\}",
		"&" : "\\perp\\left(\\pm,\\mp\\right)=\\sum_{\\nparallel=0}^{\\log_{2}\\left(\\max\\left(\\left|\\pm\\right|,\\left|\\mp\\right|,1\\right)\\right)}\\left\\{\\left\\{\\operatorname{mod}\\left(\\pm,2^{\\left(\\nparallel+1\\right)}\\right)\\ge2^{\\nparallel}\\right\\}\\left\\{\\operatorname{mod}\\left(\\mp,2^{\\left(\\nparallel+1\\right)}\\right)\\ge2^{\\nparallel}\\right\\}=1:2^{\\nparallel},0\\right\\}",
		"^" : "\\parallel\\left(\\pm,\\mp\\right)=\\sum_{\\nparallel=0}^{\\log_{2}\\left(\\max\\left(\\left|\\pm\\right|,\\left|\\mp\\right|,1\\right)\\right)}\\left\\{\\left\\{\\operatorname{mod}\\left(\\pm,2^{\\left(\\nparallel+1\\right)}\\right)\\ge2^{\\nparallel}:1,0\\right\\}+\\left\\{\\operatorname{mod}\\left(\\mp,2^{\\left(\\nparallel+1\\right)}\\right)\\ge2^{\\nparallel}:1,0\\right\\}=1:2^{\\nparallel},0\\right\\}",
	}
	DesLang.createBinary = (n1, n2, binary) => {
	if (Object.keys(DesLang.binarySymbMap).includes(binary)) {
		return n1 + DesLang.binarySymbMap[binary] + n2
	} else {
		if (binary == "**") return n1 + "^{" + n2 + "}";
		else if (binary == "/") return "\\frac{" + n1 + "}{" + n2 + "}";
		else if (binary == "!=") return bl + "\\left|" + pl + n1 + pr + "-" + pl + n2 + pr + "\\right|>0" + br;
		else if (binary == "&&") return bl + pl + n1 + pr + pl + n2 + pr + ">0" + br;
		else if (binary == "==") return bl + n1 + "=" + n2 + br;
		else if (binary == ">") return bl + n1 + ">" + n2 + br;
		else if (binary == "<") return bl + n1 + "<" + n2 + br;
		else if (binary == ">=") return bl + n1 + "\\ge " + n2 + br;
		else if (binary == "<=") return bl + n1 + "\\le " + n2 + br;
		else if (binary == "|") {
			DesLang.packageFunction("|");
			return "\\ne" + pl + n1 + "," + n2 + pr;
		} else if (binary == "&") {
			DesLang.packageFunction("&");
			return "\\perp" + pl + n1 + "," + n2 + pr;
		}
	}
}
DesLang.createUnary = (n, op) => {
if (op == "~") return pl + "-1-\\operatorname{floor}" + pl + n + pr + pr;
else if (op == "!") return pl + "1-\\operatorname{abs}" + pl + "\\operatorname{sgn}" + pl + n + pr + pr + pr;
else if (op == "@") return "..." + n;
}
}

// Desmos
Program "Program"
	= lines: (_ Line _)+ { return lines.map(e => e.filter(k => k != "")) }

Line "Line"
	= e:Statement _ ";" { return e }

Statement "Statement"
	= Folder
	/ e:Expr0 { return {
    	latex: e,
        id: DesLang.genId(),
    }}

FolderLine "FolderLine"
	= e:FolderStatement _ ";" { return e }

FolderStatement "FolderStatement"
	= e:Expr0 { return {
    	latex: e,
        id: DesLang.genId(),
    }}

List "List"
	= "[" e:(_ Expr0 _ ("," _ Expr0 _)*) "]" {
		//return [e.filter(k => k != "")[0], ...e.filter(k => k != "")[1].map(j => j.filter(k => k != ""))]
		return ll + ([e.filter(k => k != "")[0], ...e.filter(k => k != "")[1].map(j => j.filter(k => k != ""))]).reduce((start, term) => {
			return start + "," + term[1]
		}) + lr;
	}
	/ "[" e:(_ Expr0 _) "]"
	/ "[" _ "]"

Point "Point"
	= "(" _ x:Expr0 _ "," _  y:Expr0 _ ")"
	{ return pl + x + "," + y + pr }

Func "Function"
	= func:Variable _ "(" _ e:Expr0 _ ")" 
	{ return DesLang.createFunction([func, pl, e, pr]) }
	/ func:Variable _ "(" e:(_ Expr0 _ ("," _ Expr0 _)*) ")" 
	{ return DesLang.createFunction([func, pl, ...[e[1]].concat(e.filter(e => e != "")[1].map(e => e[2])), pr]) }
	/ func:Variable _ "(" _ ")"
	{ return DesLang.createFunction([func, pl, pr])}

Folder "Folder"
	= "folder" _ "(" _ name:Text _ ")" _ "{" _ contents:(FolderLine _)* "}" { 
    var id = DesLang.genId();
    contents.forEach(e => {e = e[0]; e.folderId = id})
    return [{ 
		title: name, 
		id,
        type: "folder"
	}, ...contents.map(e => e[0])]}

Expr0
	= head:Expr1 tail:(_ ("=" / "=>") _ Expr1)* {
		var setup = [head, ...tail.map(e => e.filter(k => k != ""))];
		return setup.reduce((start, term) => {
			return DesLang.createBinary(start, term[1], term[0]) 
		})
	}

Expr1
	= head:Expr2 tail:(_ ("&&" / "||") _ Expr2)* {
		var setup = [head, ...tail.map(e => e.filter(k => k != ""))];
		return setup.reduce((start, term) => {
			return DesLang.createBinary(start, term[1], term[0]) 
		})
	}

Expr2
	= head:Expr3 tail:(_ ("==" / "!=" / "<=" / ">=" / "<" / ">") _ Expr3)* {
		var setup = [head, ...tail.map(e => e.filter(k => k != ""))];
		return setup.reduce((start, term) => {
			return DesLang.createBinary(start, term[1], term[0]) 
		})
	}

Expr3
	= head:Expr4 tail:(_ ("+" / "-" / "^" / "&" / "|" / "<<" / ">>") _ Expr4)* {
		var setup = [head, ...tail.map(e => e.filter(k => k != ""))];
		return setup.reduce((start, term) => {
			return DesLang.createBinary(start, term[1], term[0]) 
		})
	}

Expr4
	= head:Expr5 tail:(_ ("*" / "/" / "%") _ Expr5)* {
		var setup = [head, ...tail.map(e => e.filter(k => k != ""))];
		return setup.reduce((start, term) => {
			return DesLang.createBinary(start, term[1], term[0]) 
		})
	}

Expr5
	= head:(Expr6 _ ("**") _)* tail:Expr6 {
		var setup = [...head.map(e => e.filter(k => k != "")), tail];
		return setup.reverse().reduce((start, term) => {
			return DesLang.createBinary(term[0], start, term[1]) 
		})
	}

Expr6
	= head:("~" / "!" / "@")* tail:Term {
		var setup = [...head, tail];
		return setup.reverse().reduce((start, term) => {
			return DesLang.createUnary(start, term[0]) 
		})
	}

Term "Term"
	= "(" _ e:Expr0 _ ")"
	//{return e}
	{ return [pl, e, pr].join("") }
	/ "-" _ e:Expr0 { return "-" + e }
	/ Func
	/ Number
	/ v:Variable { return DesLang.testKeyword(v) }
	/ Point
	/ List

Number "Number"
	= "0x" digits: HexDigits
	{ return String(parseInt(digits.join(""), 16))}
	/ "0b" digits: BinaryDigits
	{ return String(parseInt(digits.join(""), 2))}
	/ d1: Digits "." d2: Digits
	{ return String(parseFloat(d1.join("") + "." + d2.join(""), 10))}
	/ digits: Digits
	{ return String(parseInt(digits.join(""), 10))}

Digits
	= [0-9]+

HexDigits
	= [0-9a-fA-F]+

BinaryDigits
	= [01]+

Variable "Variable"
	= v:[a-zA-Z] v2:[A-Za-z0-9]+ { return v + v2.join("") }
	/ v:[a-zA-Z]

Text "Text"
	= e:[A-Za-z0-9 ]+ { return e.join("") }

_  = [ \t\r\n]* {return ""}