import React from "react"
import PropTypes from "prop-types"
import CommentReply from './CommentReply.js';
import RepliesCount from './RepliesCount.js';
import ContentEditable from 'react-contenteditable'
import qwest from 'qwest';

class Comment extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            comment: this.props.comment,
            replies: [],
            newReplyContent: '',
            replyFormContainerClass: 'hidden',
            hasMoreItems: true,
        };
    }

    handleNewReplyChange = (event) => {
        this.setState({newReplyContent: event.target.value});
    }

    toggleReplyForm = () => {
        var formClass = this.state.replyFormContainerClass;
        this.setState({replyFormContainerClass: formClass == '' ? 'hidden' : ''});
    }

    submitReply = (event) => {
        if (event.charCode == 13 && event.shiftKey == false && this.state.newReplyContent.length > 0) {
            event.preventDefault();
            var self = this;
            var url = REACT_CLIENT.api.base_url + '/stories/' + this.state.comment.story_id + '/comments';
            qwest.post(url, {
                comment: {body: this.state.newReplyContent, parent_id: this.state.comment.id}
            }, {})
                .then(function (xhr, resp) {
                    if (resp) {
                        const reply = resp.comment;
                        if (reply) {
                            var replies = self.state.replies;
                            replies.push(reply)
                            var comment = self.state.comment;
                            comment.replies_count += 1;
                            self.setState({comment: comment, replies: replies, newReplyContent: ''})
                        }
                    }
                }).catch(function (e, xhr, response) {
                    console.log(e)
                });
        }
    }

    loadReplies = () => {
        if (this.state.comment.replies_count > 0 && this.state.hasMoreItems) {
            var self = this;
            var url = REACT_CLIENT.api.base_url + '/stories/' + this.state.comment.story_id + '/comments';
            qwest.get(url, {
                parent_id: this.state.comment.id,
                skip_paginate: true,
            }, {
                cache: true
            }).then(function (xhr, resp) {
                if (resp) {
                    var replies = self.state.replies;
                    resp.comments.map((comment) => {
                        if (replies.filter(e => e.id == comment.id).length == 0) {
                            replies.push(comment);
                        }
                    });

                    self.setState({replies: replies, hasMoreItems: false})
                }
            }).catch(function (e, xhr, response) {
                console.log(e)
            });
        }
    }

    render() {
        var comment = this.state.comment;
        return (
            <li className="comment">
                <div className="avatar">
                    <a href="/test">
                        <img className="avatar"
                             src={comment.user.avatar_url}/></a>
                </div>

                <div className="comment-content">
                    <p>
                        <a href={"/" + comment.user.handle}>
                            <span className="user-name">{comment.user.handle} : </span>
                        </a>
                        <span className="comment-body">
                            {comment.body}
                        </span>

                      <span className="dropdown">
                        <i className="fa fa-ellipsis-v"></i>
                        <span className="dropdown-content">
                          <a href="javascript:void(0)" data-comment-id="1"
                             className=" text-center comment-options edit-comment">
                              <i className="sl sl-icon-pencil"></i> Edit
                          </a>
                          <a href="javascript:void(0)" data-comment-id="1" data-confirm="Are you sure?"
                             className=" text-center comment-options delete-comment">
                              <i className="fa fa-times"></i> Delete
                          </a>
                        </span>
                      </span>
                    </p>

                    <div className="comment-links">
                        <span className="linkable reply-link" onClick={this.toggleReplyForm}>Reply</span>
                        <RepliesCount comment={this.state.comment} loadReplies={this.loadReplies}/>
                    </div>
                    <ul>
                        {this.state.replies.map((reply, i) =>
                                <CommentReply key={reply.id} comment={reply}
                                              currentUser={this.currentUser}
                                              toggleReplyForm={this.toggleReplyForm}
                                    />
                        )}
                    </ul>
                    <div className={this.state.replyFormContainerClass}>
                        <div className="user-input-section reply-form">
                            <img className="avatar size32"
                                 src="http://localhost:3000/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1521db76f36eff6ab9724065f5be205c9e4cafc0/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9MY21WemFYcGxTU0lNTVRBd2VERXdNQVk2QmtWVSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--695f63dfa8ea24388f084e6ec6ad06a5eb51f42c/profile_pic2.png"/>
                            <ContentEditable
                                className="story-editable " placeholder="Write a reply.."
                                html={this.state.newReplyContent}
                                onKeyPress={this.submitReply}
                                onChange={this.handleNewReplyChange}
                                />

                        </div>
                    </div>
                </div>
            </li>
        );
    }
}

Comment.propTypes = {
    comment: PropTypes.object
};
export default Comment
