module Web.View.Posts.Show where
import Web.View.Prelude
    ( IsLabel(fromLabel),
      Either(Right, Left),
      Text,
      tshow,
      get,
      forEach,
      (|>),
      Include,
      preEscapedToHtml,
      hsx,
      timeAgo,
      Html,
      View(html),
      Comment'(author, body),
      Post,
      Post'(title, createdAt, body, id, comments),
      CommentsController(NewCommentAction),
      PostsController(PostsAction) )

import Text.MMark ( parse, render )

data ShowView = ShowView { post :: Include "comments" Post }

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
        <a href={NewCommentAction (get #id post)}>Add Comment</a>
        <div>{forEach (get #comments post) renderComment}</div>
    |]

renderComment comment = [hsx|
        <div class="mt-4">
            <h5>{get #author comment}</h5>
            <p>{get #body comment}</p>
        </div>
    |]

renderMarkdown :: Text -> Html
renderMarkdown text = 
    case parse "" text of
        Left error -> "Something went wrong"
        Right mmark -> render mmark |> tshow |> preEscapedToHtml
