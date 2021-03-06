module Web.Controller.Posts where

import Web.Controller.Prelude
    ( Monad((>>=)),
      Applicative(pure),
      Either(Right, Left),
      Text,
      modify,
      (|>),
      createRecord,
      deleteRecord,
      (.),
      CanUpdate(updateRecord),
      ifValid,
      redirectTo,
      render,
      fetchRelated,
      setSuccessMessage,
      orderByDesc,
      query,
      nonEmpty,
      validateField,
      FillParams(fill),
      Controller(action),
      Fetchable(fetch),
      Record(newRecord),
      ValidatorResult(..),
      Comment'(createdAt),
      Post,
      Post'(createdAt, comments, body, meta, title, id),
      PostsController(..) )

import Web.View.Posts.Index ( IndexView(IndexView, posts) )
import Web.View.Posts.New ( NewView(NewView, post) )
import Web.View.Posts.Edit ( EditView(EditView, post) )
import Web.View.Posts.Show ( ShowView(ShowView, post) )
import Text.MMark ( parse )

instance Controller PostsController where
    action PostsAction = do
        posts <- query @Post 
            |> orderByDesc #createdAt
            |> fetch
        render IndexView { .. }

    action NewPostAction = do
        let post = newRecord
        render NewView { .. }

    action ShowPostAction { postId } = do
        post <- fetch postId 
            >>= pure . modify #comments (orderByDesc #createdAt)
            >>= fetchRelated #comments
        render ShowView { .. }

    action EditPostAction { postId } = do
        post <- fetch postId
        render EditView { .. }

    action UpdatePostAction { postId } = do
        post <- fetch postId
        post
            |> buildPost
            |> ifValid \case
                Left post -> render EditView { .. }
                Right post -> do
                    post <- post |> updateRecord
                    setSuccessMessage "Post updated"
                    redirectTo EditPostAction { .. }

    action CreatePostAction = do
        let post = newRecord @Post
        post
            |> buildPost
            |> ifValid \case
                Left post -> render NewView { .. } 
                Right post -> do
                    post <- post |> createRecord
                    setSuccessMessage "Post created"
                    redirectTo PostsAction

    action DeletePostAction { postId } = do
        post <- fetch postId
        deleteRecord post
        setSuccessMessage "Post deleted"
        redirectTo PostsAction

isMarkdown :: Text -> ValidatorResult
isMarkdown text =
    case parse "" text of
        Left error -> Failure "Please provide valid Markdown"
        Right _ -> Success

buildPost post = post
    |> fill @["title","body"]
    |> validateField #title nonEmpty
    |> validateField #body nonEmpty
    |> validateField #body isMarkdown
