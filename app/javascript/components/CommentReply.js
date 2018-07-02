import React from "react"
import PropTypes from "prop-types"

class CommentReply extends React.Component {
    constructor(props) {
        super(props);

        this.comment = this.props.comment;
        this.user = this.comment.user;
        this.currentUser = this.props.currentUser;
    }

    render() {
        return (
            <li className="comment comment-reply">
                <div className="avatar">
                    <a href="/test">
                        <img className="avatar"
                             src={this.comment.user.avatar_url}/></a>
                </div>

                <div className="comment-content">
                    <p>
                        <a href="/test">
                            <span className="user-name">{this.comment.user.handle} : </span>
                        </a>
                        <span className="comment-body">
                            {this.comment.body}
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
                    <span className="linkable reply-link">Reply</span>
                </div>
            </li>
        );
    }
}

CommentReply.propTypes = {
    comment: PropTypes.object
};
export default CommentReply
