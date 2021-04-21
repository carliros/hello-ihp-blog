module Web.View.Posts.Show where
import Web.View.Prelude
    ( IsLabel(fromLabel),
      Either(Right, Left),
      preEscapedToHtml,
      get,
      (|>),
      hsx,
      tshow,
      timeAgo,
      Html,
      View(html),
      Post,
      Post'(title, createdAt, body),
      PostsController(PostsAction),
      Text )
import Text.MMark ( parse, render )

data ShowView = ShowView { post :: Post }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PostsAction}>Posts</a></li>
                <li class="breadcrumb-item active">Show Post</li>
            </ol>
        </nav>
        <h1>{get #title post}</h1>
        <p>{get #createdAt post |> timeAgo}</p>
        <div>{get #body post |> renderMarkdown}</div>
    |]

renderMarkdown :: Text -> Html
renderMarkdown text = 
    case parse "" text of
        Left error -> "Something went wrong"
        Right mmark -> render mmark |> tshow |> preEscapedToHtml
