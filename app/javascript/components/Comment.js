import React from "react"
import PropTypes from "prop-types"

class Comment extends React.Component {
    constructor(props) {
        super(props);

        this.comment = this.props.comment;
        this.user = this.comment.user;
    }

    render() {
        return (
            <li className="comment">
                <div className="avatar">
                    <a href="/test">
                        <img className="avatar"
                             src="http://localhost:3000/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1521db76f36eff6ab9724065f5be205c9e4cafc0/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9MY21WemFYcGxTU0lNTVRBd2VERXdNQVk2QmtWVSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--695f63dfa8ea24388f084e6ec6ad06a5eb51f42c/profile_pic2.png"/></a>
                </div>

                <div className="comment-content">
                    <p>
                        <a href="/test">
                            <span className="user-name">test : </span>
                        </a>
                        <span className="comment-body">
                        asdf asdfasd
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

                </div>
            </li>
        );
    }
}

Comment.propTypes = {
    comment: PropTypes.object
};
export default Comment
