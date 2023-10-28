import 'package:delta_markdown/delta_markdown.dart';
import 'package:test/test.dart';

void main() {
  test('Works on one line strings', () {
    const delta = '[{"insert":"Test\\n"}]';
    const expected = 'Test\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one line with header 1', () {
    const delta =
        r'[{"insert":"Heading level 1"},{"insert":"\n","attributes":{"header":1}}]';
    const expected = '# Heading level 1\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one line with header 2', () {
    const delta =
        r'[{"insert":"Heading level 2"},{"insert":"\n","attributes":{"header":2}}]';
    const expected = '## Heading level 2\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one line with header 3', () {
    const delta =
        r'[{"insert":"Heading level 3"},{"insert":"\n","attributes":{"header":3}}]';
    const expected = '### Heading level 3\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one line italic string', () {
    const delta =
        r'[{"insert":"Test","attributes":{"italic":true}},{"insert":"\n"}]';
    const expected = '_Test_\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one text with multiple inline styles', () {
    const delta =
        r'[{"attributes":{"italic":true,"bold":true},"insert":"Foo"},{"insert":"\n"}]';
    const expected = '_**Foo**_\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one line with block quote', () {
    const delta =
        r'[{"insert":"Test"},{"insert":"\n","attributes":{"blockquote":true}}]';
    const expected = '> Test\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one line with code block', () {
    const delta =
        r'[{"insert":"Test"},{"insert":"\n","attributes":{"code-block":true}}]';
    const expected = '```\nTest\n```\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one line with ordered list', () {
    const delta =
        r'[{"insert":"Test"},{"insert":"\n","attributes":{"list":"ordered"}}]';
    const expected = '1. Test\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works with horizontal line', () {
    const delta = r'[{"insert":"Foo\n"},{"insert":{"divider":"hr"}},{"insert":"Bar\n"}]';
    const expected = 'Foo\n\n---\n\nBar\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works on one line with unordered list', () {
    const delta =
        r'[{"insert":"Test"},{"insert":"\n","attributes":{"list":"bullet"}}]';
    const expected = '* Test\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works with one inline bold attribute', () {
    const delta =
        r'[{"insert":"Foo","attributes":{"bold":true}},{"insert":" bar\n"}]';
    const expected = '**Foo** bar\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works with one link', () {
    const delta =
        r'[{"insert":"FooBar","attributes":{"link":"http://foo.bar"}},{"insert":"\n"}]';
    const expected = '[FooBar](http://foo.bar)\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });

  test('Works with one image', () {
    const delta = r'[{"insert":{"image":"http://image.jpg"}},{"insert":"\n"}]';
    const expected = '![](http://image.jpg)\n';

    final result = deltaToMarkdown(delta);

    expect(result, expected);
  });
}
