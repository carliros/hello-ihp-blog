module Web.Controller.Posts where

import Web.Controller.Prelude
    ( HasField,
      Either(Right, Left),
      (|>),
      createRecord,
      deleteRecord,
      SetField,
      CanUpdate(updateRecord),
      MetaBag,
      nonEmpty,
      validateField,
      ControllerContext,
      Record(newRecord),
      ifValid,
      redirectTo,
      render,
      setSuccessMessage,
      query,
      FillParams(fill),
      ParamReader,
      Controller(action),
      Fetchable(fetch),
      Post,
      Post'(meta, id, title),
      PostsController(..) )
import Web.View.Posts.Index ( IndexView(IndexView, posts) )
import Web.View.Posts.New ( NewView(NewView, post) )
import Web.View.Posts.Edit ( EditView(EditView, post) )
import Web.View.Posts.Show ( ShowView(ShowView, post) )

instance Controller PostsController where
    action PostsAction = do
        posts <- query @Post |> fetch
        render IndexView { .. }

    action NewPostAction = do
        let post = newRecord
        render NewView { .. }

    action ShowPostAction { postId } = do
        post <- fetch postId
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

buildPost post = post
    |> fill @["title","body"]
    |> validateField #title nonEmpty
