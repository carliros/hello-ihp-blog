module Web.View.Posts.Show where
import Web.View.Prelude
    ( IsLabel(fromLabel),
      get,
      (|>),
      UTCTime(UTCTime),
      hsx,
      timeAgo,
      View(html),
      Post,
      Post'(title, createdAt, body),
      PostsController(PostsAction) )

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
        <div>{get #body post}</div>
    |]
