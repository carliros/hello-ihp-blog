module Web.View.Posts.Edit where
import Web.View.Prelude
    ( IsLabel(fromLabel),
      hsx,
      formFor,
      submitButton,
      textField,
      Html,
      View(html),
      Post,
      Post'(meta, title, body, id),
      PostsController(PostsAction) )

data EditView = EditView { post :: Post }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PostsAction}>Posts</a></li>
                <li class="breadcrumb-item active">Edit Post</li>
            </ol>
        </nav>
        <h1>Edit Post</h1>
        {renderForm post}
    |]

renderForm :: Post -> Html
renderForm post = formFor post [hsx|
    {(textField #title)}
    {(textField #body)}
    {submitButton}
|]