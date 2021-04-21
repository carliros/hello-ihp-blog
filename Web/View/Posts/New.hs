module Web.View.Posts.New where
import Web.View.Prelude
    ( IsLabel(fromLabel),
      hsx,
      formFor,
      submitButton,
      textField,
      textareaField,
      helpText,
      Html,
      View(html),
      Post,
      Post'(meta, title, body, id),
      PostsController(PostsAction) )

data NewView = NewView { post :: Post }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PostsAction}>Posts</a></li>
                <li class="breadcrumb-item active">New Post</li>
            </ol>
        </nav>
        <h1>New Post</h1>
        {renderForm post}
    |]

renderForm :: Post -> Html
renderForm post = formFor post [hsx|
    {(textField #title)}
    {(textareaField #body) { helpText = "You can use Markdown here"} }
    {submitButton}
|]
