import React from "react"
import PropTypes from "prop-types"
import StoryShare from './StoryShare.js';
import StoryComments from './StoryComments.js';

class Story extends React.Component {
    constructor(props) {
        super(props);

        this.story = this.props.story;
        this.user = this.story.user;
        this.currentUser = this.props.currentUser;
        this.handleInspired = this.props.handleInspired;
    }
    render() {
        return (
            <div className="story-item story-item-popup UserSmallListItem"
                 data-story-id={this.story.id}>
                <div className="content">
                    <a className="account-group user-thumb" href={'/' + this.user.handle}>
                        <img className="avatar"
                             src={this.user.avatar_url}/>
                            <span className="account-group-inner">
                            <strong className="fullname">{this.user.name}</strong>
                          <span className="UserBadges"></span><span className="UserNameBreak">&nbsp;</span>
                          <span className="username u-dir u-textTruncate" dir="ltr">@<b>{this.user.handle}</b></span>
                          </span>
                    </a>

                    <p className="story-content">
                        {this.story.description}
                    </p>
                </div>
                <StoryShare story={this.story} handleInspired={this.handleInspired} currentUser={this.currentUser}/>
                <StoryComments story={this.story}  currentUser={this.currentUser}/>
            </div>
        );
    }
}

Story.propTypes = {
    story: PropTypes.object
};
export default Story
