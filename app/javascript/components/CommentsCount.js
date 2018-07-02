import React from "react"
import PropTypes from "prop-types"

class CommentsCount extends React.Component {
    constructor(props) {
        super(props);
        this.story = this.props.story;
    }

    commentsCountClasses = () => {
        var classes = "comments-count ";
        if (this.story.comments_count > 0) {
            classes += "linkable"
        }
        return classes;
    }

    render() {
        return (
            <span className={this.commentsCountClasses()} onClick={this.props.loadRootComments}>
              {this.story.comments_count} {this.story.comments_count == 1 ? 'Comment' : 'Comments'}
            </span>
        );
    }
}

CommentsCount.propTypes = {
    comment: PropTypes.object
};
export default CommentsCount
