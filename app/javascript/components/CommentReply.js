import React from "react"
import PropTypes from "prop-types"
import TimeAgo from 'react-timeago'
import CommentOptions from './CommentOptions.js';
import ContentEditable from 'react-contenteditable'
import qwest from 'qwest';

class CommentReply extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            comment: this.props.comment,
            editingComment: false,
        };
    }

    editComment = () => {
        this.setState({editingComment: true});
    }

    cancelEditing = () => {
        this.setState({editingComment: false});
    }

    submitUpdate = (event) => {
        if (event.charCode == 13 && event.shiftKey == false && this.state.comment.body.length > 0) {
            event.preventDefault();
            var self = this;
            var url = REACT_CLIENT.api.base_url + '/stories/' +
                this.state.comment.story_id + '/comments/' + this.state.comment.id;
            qwest.put(url, {
                comment: {body: this.state.comment.body}
            }, {})
                .then(function (xhr, resp) {
                    if (resp) {
                        self.props.onReplyUpdated(resp.comment);
                        self.cancelEditing();
                    }
                }).catch(function (e, xhr, response) {
                    console.log(e)
                });
        }
    }

    handleEditCommentChange = (event) => {
        let comment = this.state.comment;
        comment.body = event.target.value
        this.setState({comment: comment});
    }

    render() {
        var {comment} = this.state;
        return (
            <li className="comment comment-reply">
                <div className="avatar">
                    <a href="/test">
                        <img className="avatar"
                             src={comment.user.avatar_url}/></a>
                </div>

                <div className="comment-content">
                    {!this.state.editingComment &&
                    <p>
                        <a href="/test">
                            <span className="user-name">{comment.user.handle} : </span>
                        </a>
                        <span className="comment-body">
                            {comment.body}
                        </span>
                        <CommentOptions comment={comment}
                                        editComment={this.editComment}
                                        deleteComment={this.props.deleteReply}
                                        currentUser={this.props.currentUser}/>
                    </p>
                    }
                    {this.state.editingComment &&
                    <div>
                        <ContentEditable
                            className="story-editable edit-story"
                            html={comment.body}
                            onKeyPress={this.submitUpdate}
                            onChange={this.handleEditCommentChange}
                            />
                        <span className="cancel-edit-comment" onClick={this.cancelEditing}>Cancel</span>
                    </div>
                    }
                    <div className="comment-links">
                        <span className="linkable reply-link" onClick={this.props.toggleReplyForm}>Reply</span>
                    <span className="time-ago">
                            <TimeAgo date={comment.created_at}/>
                        </span>
                    </div>
                </div>
            </li>
        );
    }
}

CommentReply.propTypes = {
    comment: PropTypes.object
};
export default CommentReply
