import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import PropTypes from "prop-types"
import InfiniteScroll from 'react-infinite-scroller';
import update from 'immutability-helper';
import qwest from 'qwest';
import Story from '../Story.js';
import NewStory from '../NewStory.js';

class UserStoryList extends React.Component {
    constructor(props) {
        super(props);

        var currentUser = props.current_user || {}
        currentUser.inspiredStoryIds = currentUser.inspiredStoryIds || []

        var stories = [];
        if (props.single_view) {
            var story = props.story_data.story;
            story.current_user_inspired = props.current_user_inspired;
            stories = [story];
        }

        this.state = {
            currentUser: currentUser,
            userId: props.user_id,
            stories: stories,
            singleView: props.single_view,
            hasMoreItems: !props.single_view,
            page: 1
        };
    }

    loadItems(page) {
        var self = this;
        var url = REACT_CLIENT.api.base_url + '/stories';
        qwest.get(url, {
            user_id: this.state.userId,
            per_page: 10,
            current_user_meta: true,
            page: this.state.page
        }, {
            cache: true
        })
            .then(function (xhr, resp) {
                if (resp) {
                    var metaData = resp.meta;
                    var currentUser = self.state.currentUser;

                    if (metaData && metaData.inspired_story_ids)
                        currentUser.inspiredStoryIds.push(...metaData.inspired_story_ids)

                    var stories = self.state.stories;
                    resp.stories.map((story) => {
                        if (currentUser.inspiredStoryIds.indexOf(story.id) >= 0)
                            story.current_user_inspired = true;

                        stories.push(story);
                    });

                    var stateData = {
                        stories: stories,
                        currentUser: currentUser,
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

    handleInspired = (story) => {
        var self = this;
        var url = REACT_CLIENT.api.base_url + '/stories/' + story.id + '/inspired';
        qwest.post(url, {
            user_id: this.state.currentUser.id,
        }, {})
            .then(function (xhr, resp) {
                if (resp) {
                    var {inspiration, deleted} = resp;
                    if (!deleted) {
                        story.inspirations_count = story.inspirations_count + 1;
                        story.current_user_inspired = true;
                    } else {
                        story.inspirations_count = story.inspirations_count - 1;
                        story.current_user_inspired = false;
                    }

                    const index = self.state.stories.findIndex((_story) => _story.id === story.id);
                    const updatedStories = update(self.state.stories, {$splice: [[index, 1, story]]});
                    self.setState({stories: updatedStories});
                }
            });
    }

    onStoryAdded = (story) => {
        var stories = this.state.stories;
        stories.unshift(story)
        this.setState({stories: stories});
    }
    render() {
        const loader = <div className="loader" key={0}>Loading ...</div>;

        var items = [];
        this.state.stories.map((story, i) => {
            items.push(
                <Story key={story.id} story={story} handleInspired={this.handleInspired}
                       currentUser={this.state.currentUser}/>
            );
        });

        return (
            <div>
                <NewStory onStoryAdded={this.onStoryAdded}/>
                <InfiniteScroll
                    pageStart={0}
                    loadMore={this.loadItems.bind(this)}
                    hasMore={this.state.hasMoreItems}
                    loader={loader}>

                    <div className="stories" id="story_list">
                        {items}
                    </div>
                </InfiniteScroll>
            </div>
        );
    }

}

UserStoryList.propTypes = {
    userId: PropTypes.node
};
export default UserStoryList
