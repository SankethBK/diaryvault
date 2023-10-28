A portable Markdown library written in Dart.
It can convert between Markdown and Delta.

**The converter is not ready for production**

### Usage

```dart
import 'package:delta_markdown/delta_markdown.dart';

void main() {
  const markdown = 'Hello **Markdown**';
  print(markdownToDelta(markdown));

  const delta = r'[{"insert":"Hello "},{"insert":"Markdown","attributes":{"bold":true}},{"insert":"\n"}]';
  print(deltaToMarkdown(delta));
}
```

### Supports

Currently, these elements are supported:

- Bold
- Italic
- Link
- Blockquote
- Header
- List
- Code Block
- Image
- Horizontal Rule

Does not support the following elements, because Markdown does not support them:

- Background Color
- Color
- Font
- Size
- Strikethrough
- Superscript/Subscript
- Underline
- Text Alignment
- Text Direction
- Formula
- Video

Does not support the following elements, because flutter_quill does not support them:
- Inline Code

### Known limits
Support for these elements must be implemented:
- Indent

There are only a few tests so far, so the functionality is not yet guaranteed in complex cases.
