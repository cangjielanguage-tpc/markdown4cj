4.  What is the exact rule for determining when list items get
    wrapped in `<p>` tags?  Can a list be partially "loose" and partially
    "tight"?  What should we do with a list like this?

    ``` markdown
    1. one

    2. two
    3. three
    ```

    (There are some relevant comments by John Gruber
    [here](http://article.gmane.org/gmane.text.markdown.general/2554).)

13. - Can link references be defined inside block quotes or list items?
    - markdown
    - Blockquote [foo].    
    - [foo]: /url

19. If there are multiple definitions for the same reference, which takes
    precedence?

    ``` markdown
    [foo]: /url1
    [foo]: /url2

    [foo][]
    ```

19. If there are multiple definitions for the same reference, which takes
    precedence?

    2. 1.2
    2. 1.3
    2. 1.4

> 3. The overriding design goal for Markdown's formatting syntax is
> 2. to make it as readable as possible. The idea is that a
>> Markdown-formatted document should be publishable as-is, as
>>>    plain text, without looking like it's been marked up with tags
>>>     plain text, without looking like it's been marked up with tags
> or formatting instructions.