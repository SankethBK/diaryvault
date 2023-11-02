import 'package:delta_markdown/delta_markdown.dart';
import 'package:test/test.dart';

void main() {
  test('Works on one line strings', () {
    const markdown = 'Test\n';
    const expected = '[{"insert":"Test\\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one line with header 1', () {
    const markdown = '# Heading level 1\n';
    const expected =
        r'[{"insert":"Heading level 1"},{"insert":"\n","attributes":{"header":1}}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one line with header 2', () {
    const markdown = '## Heading level 2\n';
    const expected =
        r'[{"insert":"Heading level 2"},{"insert":"\n","attributes":{"header":2}}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one line with header 3', () {
    const markdown = '### Heading level 3\n';
    const expected =
        r'[{"insert":"Heading level 3"},{"insert":"\n","attributes":{"header":3}}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one line italic string', () {
    const markdown = '_Test_\n';
    const expected =
        r'[{"insert":"Test","attributes":{"italic":true}},{"insert":"\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one line with block quote', () {
    const markdown = '> Test\n';
    const expected =
        r'[{"insert":"Test"},{"insert":"\n","attributes":{"blockquote":true}}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one line with code block', () {
    const markdown = '```\nTest\n```\n';
    const expected =
        '[{"insert":"Test"},{"insert":"\\n","attributes":{"code-block":true}}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one line with ordered list', () {
    const markdown = '1. Test\n';
    const expected =
        r'[{"insert":"Test"},{"insert":"\n","attributes":{"list":"ordered"}}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one line with unordered list', () {
    const markdown = '* Test\n';
    const expected =
        r'[{"insert":"Test"},{"insert":"\n","attributes":{"list":"bullet"}}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works with one inline bold attribute', () {
    const markdown = '**Foo** bar\n';
    const expected =
        r'[{"insert":"Foo","attributes":{"bold":true}},{"insert":" bar\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works on one text with multiple inline styles', () {
    const markdown = '_**Foo**_\n';
    const expected =
        r'[{"insert":"Foo","attributes":{"italic":true,"bold":true}},{"insert":"\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works with one link', () {
    const markdown = '[FooBar](http://foo.bar)\n';
    const expected =
        r'[{"insert":"FooBar","attributes":{"link":"http://foo.bar"}},{"insert":"\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works with one image', () {
    const markdown = '![](http://image.jpg)\n';
    const expected =
        r'[{"insert":{"image":"http://image.jpg"}},{"insert":"\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works not with inline code', () {
    // flutter_quill does not support inline code currently.
    const markdown = '`Foo` bar\n';
    const expected = r'[{"insert":"Foo bar\n"}]';

    // This should be the expected output when flutter_quill supports code:
    // r'[{"insert":"Foo","attributes":{"code":true}},{"insert":" bar\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works with greater and smaller symbol in code', () {
    const markdown = '```\n<br />\n```';
    const expected =
        r'[{"insert":"<br />"},{"insert":"\n","attributes":{"code-block":true}}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works with &-symbol', () {
    const markdown = 'Foo & Bar\n';
    const expected = r'[{"insert":"Foo & Bar\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });

  test('Works with horizontal line', () {
    const markdown = 'Foo\n\n---\n\nBar\n';
    const expected =
        r'[{"insert":"Foo\n"},{"insert":{"divider":"hr"}},{"insert":"Bar\n"}]';

    final result = markdownToDelta(markdown);

    expect(result, expected);
  });
}
