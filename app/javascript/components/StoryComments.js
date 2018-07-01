import React from "react"
import PropTypes from "prop-types"
import qwest from 'qwest';
import Comment from './Comment.js';

class StoryComments extends React.Component {
    constructor(props) {
        super(props);

        var rootComments = [];
        this.state = {
            story: props.story,
            comments: [],
            rootComments: rootComments,
            hasMoreItems: true,
            page: 1
        };
    }

    loadRootComments = () => {
        if (this.state.story.comments_count > 0) {
            var self = this;
            var url = REACT_CLIENT.api.base_url + '/stories/' + this.state.story.id + '/comments' ;
            qwest.get(url, {
                root_comments: true,
                per_page: 10,
                current_user_meta: true,
                page: this.state.page
            }, {
                cache: true
            })
                .then(function (xhr, resp) {
                    if (resp) {
                        var metaData = resp.meta;
                        var comments = self.state.comments;

                        comments = resp.comments.concat(comments);
                        var stateData = {
                            comments: comments
                        }
                        if (metaData.next_page) {
                            self.setState(Object.assign(stateData, {page: metaData.next_page}));
                        } else {
                            self.setState(Object.assign(stateData, {hasMoreItems: false}));
                        }
                    }
                }).catch(function(e, xhr, response) {
                    console.log(e)
                });
        }
    }

    commentsCountClasses = () => {
        var classes = "comments-count ";
        if (this.state.story.comments_count > 0) {
            classes += "linkable"
        }
        return classes;
    }

    handleEdit = () => {

    }

    render() {
        var story = this.state.story;
        return (
            <div className="comments-section">
                <div className="comments-summary">
                     <span className={this.commentsCountClasses()} onClick={this.loadRootComments}>
                        {story.comments_count} {story.comments_count == 1 ? 'Comment' : 'Comments'}
                    </span>
                </div>
                <ul>
                    {this.state.comments.map((comment, i) =>
                        <Comment key={comment.id} comment={comment} handleEdit={this.handleEdit}/>
                    )}
                </ul>
                <div className="user-input-section comment-form">
                    <img className="avatar size32"
                         src="http://localhost:3000/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1521db76f36eff6ab9724065f5be205c9e4cafc0/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9MY21WemFYcGxTU0lNTVRBd2VERXdNQVk2QmtWVSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--695f63dfa8ea24388f084e6ec6ad06a5eb51f42c/profile_pic2.png"/>
                    <a href="javascript:void(0)" commentable="true" story-id="1"
                       className="story-editable popup-with-zoom-anim" placeholder="What's your
          comment?" contentEditable="true"></a>
                </div>
            </div>
        );
    }
}

StoryComments.propTypes = {
    story: PropTypes.object
};
export default StoryComments
