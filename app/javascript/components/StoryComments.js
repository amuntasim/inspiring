import React from "react"
import PropTypes from "prop-types"
import qwest from 'qwest';
import Comment from './Comment.js';
import CommentsCount from './CommentsCount.js';
import ContentEditable from 'react-contenteditable'

class StoryComments extends React.Component {
    constructor(props) {
        super(props);

        var rootComments = [];
        this.state = {
            story: props.story,
            comments: [],
            rootComments: rootComments,
            hasMoreItems: true,
            newCommentContent: '',
            page: 1
        };
    }

    loadRootComments = () => {
        if (this.state.story.comments_count > 0 && this.state.hasMoreItems) {
            var self = this;
            var url = REACT_CLIENT.api.base_url + '/stories/' + this.state.story.id + '/comments';
            qwest.get(url, {
                root_comments: true,
                per_page: 10,
                current_user_meta: true,
                page: this.state.page
            }, {
                cache: true
            }).then(function (xhr, resp) {
                if (resp) {
                    var metaData = resp.meta;
                    var comments = self.state.comments;

                    resp.comments.map((comment) => {
                        if (comments.filter(e => e.id == comment.id).length == 0) {
                            comments.unshift(comment);
                        }
                    });

                    var stateData = {
                        comments: comments
                    }
                    if (metaData.next_page) {
                        self.setState(Object.assign(stateData, {page: metaData.next_page}));
                    } else {
                        self.setState(Object.assign(stateData, {hasMoreItems: false}));
                    }
                }
            }).catch(function (e, xhr, response) {
                console.log(e)
            });
        }
    }



    handleEdit = () => {

    }

    handleNewCommentChange = (event) => {
        this.setState({newCommentContent: event.target.value});
    }

    submitComment = (event) => {
        if (event.charCode == 13 && event.shiftKey == false && this.state.newCommentContent.length > 0) {
            event.preventDefault();
            var self = this;
            var url = REACT_CLIENT.api.base_url + '/stories/' + this.state.story.id + '/comments';
            qwest.post(url, {
                comment: {body: this.state.newCommentContent}
            }, {})
                .then(function (xhr, resp) {
                    if (resp) {
                        const comment = resp.comment;
                        if (comment) {
                            var comments = self.state.comments;
                            comments.unshift(comment)
                            var story = self.state.story;
                            story.comments_count += 1;
                            self.setState({story: story, comments: comments, newCommentContent: ''})
                        }
                    }
                }).catch(function (e, xhr, response) {
                    console.log(e)
                });
        }
    }

    render() {
        return (
            <div className="comments-section">
                <div className="comments-summary">
                   <CommentsCount story={this.state.story} loadRootComments={this.loadRootComments}/>
                    {this.state.page > 1 && this.state.hasMoreItems &&
                    <span className="linkable" onClick={this.loadRootComments}> Load more comments</span>
                    }
                </div>
                <ul>
                    {this.state.comments.map((comment, i) =>
                            <Comment key={comment.id} comment={comment} handleEdit={this.handleEdit}/>
                    )}
                </ul>
                <div className="user-input-section comment-form">
                    <img className="avatar size32"
                         src="http://localhost:3000/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1521db76f36eff6ab9724065f5be205c9e4cafc0/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9MY21WemFYcGxTU0lNTVRBd2VERXdNQVk2QmtWVSIsImV4cCI6bnVsbCwicHVyIjoidmFyaWF0aW9uIn19--695f63dfa8ea24388f084e6ec6ad06a5eb51f42c/profile_pic2.png"/>
                    <ContentEditable
                        className="story-editable " placeholder="What's your comment?"
                        html={this.state.newCommentContent}
                        onKeyPress={this.submitComment}
                        onChange={this.handleNewCommentChange}
                        />

                </div>
            </div>
        );
    }
}


StoryComments.propTypes = {
    story: PropTypes.object
};
export default StoryComments
