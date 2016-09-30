// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:parsers/parsers.dart';

import './node.dart';

class EnvSubstParser {
  Parser get _escapedTextPart1 =>
      string(r'\${') + anyChar.manyUntil(char('}')) ^
      (x, xs) => new TextNode(x + xs.join('') + '}');
  Parser get _escapedTextPart2 =>
      string(r'\$') + alphanum.many1 ^ (x, xs) => new TextNode(x + xs.join(''));
  Parser get _escapedText => _escapedTextPart1 | _escapedTextPart2;

  Parser get _text =>
      anyChar + noneOf(r'$}\').many ^ (x, xs) => new TextNode(x + xs.join(''));

  Parser get _variablePart =>
      alphanum.many1 ^ (xs) => new VariableNode(xs.join(''));
  Parser get _variable => char(r'$') > _variablePart;

  Parser get _colonPlus => string(':+') ^ (_) => ExpType.colonPlus;
  Parser get _colonDash => string(':-') ^ (_) => ExpType.colonDash;
  Parser get _expType => _colonPlus | _colonDash;
  Parser get _defaultNode =>
      _expType + (_variable | _text) ^ (expType, node) => [expType, node];
  Parser get _substitutionPart =>
      _variablePart + _defaultNode.maybe ^
      (variableNode, option) {
        final expType = option.isDefined ? option.value[0] : ExpType.none;
        final defaultNode = option.isDefined ? option.value[1] : null;
        return new SubstitutionNode(variableNode, expType, defaultNode);
      };
  Parser get _substitution => string(r'${') > (_substitutionPart < char('}'));

  Parser get _node => choice([_escapedText, _substitution, _variable, _text]);
  Parser get _doc => _node.many < eof;

  List<Node> parse(String input) => _doc.parse(input);
}
