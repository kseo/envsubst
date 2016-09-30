// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

enum NodeType { text, substitution, variable }

abstract class Node {
  NodeType get nodeType;
}

class TextNode implements Node {
  @override
  NodeType get nodeType => NodeType.text;

  final String text;

  TextNode(this.text);

  @override
  String toString() => text;
}

class VariableNode implements Node {
  @override
  NodeType get nodeType => NodeType.variable;

  final String id;

  bool get isSet => Platform.environment.containsKey(id);

  VariableNode(this.id);

  @override
  String toString() => Platform.environment[id] ?? '';
}

enum ExpType { none, colonDash, colonPlus }

class SubstitutionNode implements Node {
  @override
  NodeType get nodeType => NodeType.substitution;

  final VariableNode variableNode;

  final ExpType expType;

  final Node defaultNode;

  SubstitutionNode(this.variableNode, this.expType, this.defaultNode);

  @override
  String toString() {
    switch (expType) {
      case ExpType.colonDash:
        if (!variableNode.isSet) {
          return defaultNode.toString();
        }
        break;
      case ExpType.colonPlus:
        if (variableNode.isSet) {
          return defaultNode.toString();
        }
        break;
      default:
        break;
    }
    return variableNode.toString();
  }
}

