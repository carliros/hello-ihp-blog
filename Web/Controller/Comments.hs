module Web.Controller.Comments where

import Web.Controller.Prelude
    ( Either(Right, Left),
      (|>),
      createRecord,
      deleteRecord,
      CanUpdate(updateRecord),
      ifValid,
      redirectTo,
      render,
      setSuccessMessage,
      set,
      get,
      query,
      FillParams(fill),
      Controller(action),
      Fetchable(fetch),
      Record(newRecord),
      Comment,
      Comment'(meta, id, postId),
      CommentsController(..),
      PostsController(..) )
import Web.View.Comments.Index ( IndexView(IndexView, comments) )
import Web.View.Comments.New ( NewView(NewView, comment, post) )
import Web.View.Comments.Edit ( EditView(EditView, comment) )
import Web.View.Comments.Show ( ShowView(ShowView, comment) )

instance Controller CommentsController where
    action CommentsAction = do
        comments <- query @Comment |> fetch
        render IndexView { .. }

    action NewCommentAction { postId } = do
        let comment = newRecord 
                |> set #postId postId
        post <- fetch postId
        render NewView { .. }

    action ShowCommentAction { commentId } = do
        comment <- fetch commentId
        render ShowView { .. }

    action EditCommentAction { commentId } = do
        comment <- fetch commentId
        render EditView { .. }

    action UpdateCommentAction { commentId } = do
        comment <- fetch commentId
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> render EditView { .. }
                Right comment -> do
                    comment <- comment |> updateRecord
                    setSuccessMessage "Comment updated"
                    redirectTo ShowPostAction { postId = get #postId comment }

    action CreateCommentAction = do
        let comment = newRecord @Comment
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> do
                    post <- fetch (get #postId comment)
                    render NewView { .. } 
                Right comment -> do
                    comment <- comment |> createRecord
                    setSuccessMessage "Comment created"
                    redirectTo ShowPostAction { postId = get #postId comment }

    action DeleteCommentAction { commentId } = do
        comment <- fetch commentId
        deleteRecord comment
        setSuccessMessage "Comment deleted"
        redirectTo CommentsAction

buildComment comment = comment
    |> fill @["postId","author","body"]
