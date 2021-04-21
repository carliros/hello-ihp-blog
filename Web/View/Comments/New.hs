module Web.View.Comments.New where
import Web.View.Prelude
    ( IsLabel(fromLabel),
      hsx,
      formFor,
      submitButton,
      textField,
      hiddenField,
      get,
      Html,
      View(html),
      Comment,
      Comment'(meta, postId, author, body, id),
      Post,
      Post'(title),
      CommentsController(CommentsAction) )

data NewView = NewView { comment :: Comment, post :: Post }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={CommentsAction}>Comments</a></li>
                <li class="breadcrumb-item active">New Comment</li>
            </ol>
        </nav>
        <h1>New Comment for {get #title post}</h1>
        {renderForm comment}
    |]

renderForm :: Comment -> Html
renderForm comment = formFor comment [hsx|
    {(hiddenField #postId)}
    {(textField #author)}
    {(textField #body)}
    {submitButton}
|]
