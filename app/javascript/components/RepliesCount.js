import React from "react"
import PropTypes from "prop-types"

class RepliesCount extends React.Component {
    constructor(props) {
        super(props);
        this.comment = this.props.comment;
    }

    commentsCountClasses = () => {
        var classes = "comments-count reply-link ";
        if (this.comment.replies_count > 0) {
            classes += "linkable"
        }else {
            classes += "hidden"
        }
        return classes;
    }

    render() {
        return (
            <span className={this.commentsCountClasses()} onClick={this.props.loadReplies}>
              {this.comment.replies_count} {this.comment.replies_count == 1 ? 'Reply' : 'Replies'}
            </span>
        );
    }
}

RepliesCount.propTypes = {
    comment: PropTypes.object
};
export default RepliesCount
