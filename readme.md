grammar.js is from Mohamad Omar Nachawati <mnachawa@gmail.com>

how to build:
```bash
npm install
npm run build
```

```javascript
import Parser from 'tree-sitter';
import * as fs from 'fs';

const Modelica = require('/mnt/tree-sitter-modelica/build/Release/tree_sitter_modelica_binding.node');

const parser = new Parser();

parser.setLanguage(Modelica);

let sourceCode = 'model SimpleEx Real a, b, c, d, e; equation sqrt ( a ) = 65 " Equation f1"; d = a /( b* e ) " Equation f2"; e = d ^3 " Equation f3"; b = sqrt ( e ) " Equation f4"; 0 = a ^2 + c " Equation f5"; end SimpleEx ; ';

const testCode = complexCode2;
const tree = parser.parse(testCode);
// console.log(tree.rootNode.toString());

function treeToJson(node: Parser.SyntaxNode): any {
    const result: any = {
        type: node.type,
        startPosition: node.startPosition,
        endPosition: node.endPosition
    };

    const children = node.namedChildren.map(child => treeToJson(child));
    if (children.length > 0) {
        result.children = children;
    }

    return result;
}
function treeToJsonWithText(node: Parser.SyntaxNode, sourceCode: string): any {
    const result: any = {
        type: node.type,
        startPosition: node.startPosition,
        endPosition: node.endPosition,
        text: node.text // 获取节点的原始文本内容
    };

    const children = node.namedChildren.map(child => treeToJsonWithText(child, sourceCode));
    if (children.length > 0) {
        result.children = children;
    }

    return result;
}
// const jsonAst = treeToJson(tree.rootNode);
const jsonAstWithText = treeToJsonWithText(tree.rootNode, testCode);
// const jsonString = JSON.stringify(jsonAst, null, 2);
const jsonString = JSON.stringify(jsonAstWithText, null, 2);
const filePath = '../example/ast.json'; // 你想要保存的文件名和路径

try {
    fs.writeFileSync(filePath, jsonString, 'utf-8');
    console.log(`AST 已保存到 ${filePath}`);
} catch (error) {
    console.error('保存 AST 到文件时发生错误:', error);
}
```